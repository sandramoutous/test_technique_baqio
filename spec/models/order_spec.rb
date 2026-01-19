require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:account) { FactoryBot.create(:account) }
  let(:customer) { FactoryBot.build(:andrea, account: account) }
  let(:order) { FactoryBot.create(:order, account: account, customer: customer) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end

    it 'is invalid without a reference' do
      order.reference = nil
      expect(order).not_to be_valid
    end
    it 'requires the presence of a reference' do
      expect(Order.new).not_to be_valid
    end

    it 'is invalid with a duplicate reference' do
      order.save!
      duplicate = order.dup
      expect(duplicate).not_to be_valid
    end

    it 'is valid if STATUSES include status' do
      expect(Order::STATUSES).to include(order.status)
    end

    it 'is invalid with a wrong status' do
      order.status = "waiting"
      expect(order).not_to be_valid
    end
  end

  describe 'statuses' do
    it 'equals true if validated status' do
      expect(order.validated?).to be true
    end

    it 'equals false if status not validated' do
      expect(order.pending?).to be false
    end
  end

  describe '#cancel' do
    it 'returns nil if order cancelled' do
      order.status = 'cancelled'
      expect(order.cancel).to be nil
    end

    # with AI support
    context 'when order is invoiced' do
      it 'calls the Invoice::Create service' do
        order.status = 'invoiced'

        service_double = double('Invoice::Create')
        expect(Invoice::Create).to receive(:new).with(order, 'credit').and_return(service_double)
        expect(service_double).to receive(:call)
        order.cancel
      end
    end

    context 'when order is validated' do
      it 'calls the Order::Cancellation service' do
        order.status = 'validated'
        service_double = double('Order::Cancellation')
        expect(Order::Cancellation).to receive(:new).with(order).and_return(service_double)
        expect(service_double).to receive(:call)
        order.cancel
      end
    end
  end

  describe 'fulfillment' do
    it 'returns nil if fulfillment does not exist' do
      expect(order.fulfillment_status).to be_nil
    end

    it 'returns fulfillment status' do
      order.fulfillment = Fulfillment.new(status: 'shipped')
      expect(order.fulfillment_status).to eq('shipped')
    end
  end

  describe '#total_quantity' do
    context 'when the order has multiple order lines' do
      let(:order_line) { OrderLine.create!(order: order, name: 'Macôn (caisse 24)', quantity: 5) }
      let(:order_line2) { OrderLine.create!(order: order, name: 'Cidre brut', quantity: 3) }

      it 'returns the order_lines quantity sum' do
        order_line
        order_line2
        expect(order.total_quantity).to eq(8)
      end
    end
  end
end
