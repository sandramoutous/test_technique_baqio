require 'rails_helper'

RSpec.describe Invoice::Create do
  let(:account) { FactoryBot.create(:account) }
  let(:order) { FactoryBot.create(:order, account: account, status: 'pending') }

  describe 'initialization' do
    it 'raises an ArgumentError if initialized without 2 arguments' do
      expect { Invoice::Create.new }.to raise_error(ArgumentError)
    end

    it 'does not raise an error if initialized with 2 arguments' do
      expect { Invoice::Create.new(order, 'credit') }.not_to raise_error
    end
  end

  # with AI support
  describe '#call' do
    context 'when status == credit' do
      let(:invoice_service) { Invoice::Create.new(order, 'credit') }

      it 'creates a new invoice' do
        expect { invoice_service.call }.to change(Invoice, :count).by(1)
      end

      it 'changes order status with cancelled' do
        invoice_service.call
        expect(order.reload.status).to eq('cancelled')
      end

      it 'creates an event_account' do
        expect { invoice_service.call }.to change(AccountEvent, :count).by(1)
      end

      it 'creates an event_account with invoice resource and credit topic' do
        invoice_service.call
        expect(AccountEvent.last.resource_type).to eq('Invoice')
        expect(AccountEvent.last.topic).to eq('invoice.credit.create')
      end
    end

    context 'when status != credit' do
      let(:invoice_service) { Invoice::Create.new(order, 'debit') }
      it 'creates a new invoice' do
        expect { invoice_service.call }.to change(Invoice, :count).by(1)
      end

      it 'changes order status with invoiced' do
        invoice_service.call
        expect(order.reload.status).to eq('invoiced')
      end

      it 'creates an event_account with invoice resource and debit topic' do
        invoice_service.call
        expect(AccountEvent.last.resource_type).to eq('Invoice')
        expect(AccountEvent.last.topic).to eq('invoice.debit.create')
      end
    end
  end
end
