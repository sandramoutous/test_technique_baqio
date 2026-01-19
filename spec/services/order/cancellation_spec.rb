require 'rails_helper'

RSpec.describe Order::Cancellation do
  let(:account) { FactoryBot.create(:account) }
  let(:order) { FactoryBot.create(:order, account: account, status: 'pending') }
  let(:order_service) { Order::Cancellation.new(order) }


  describe 'initialization' do
    it 'raises an ArgumentError if initialized without arguments' do
      expect { Order::Cancellation.new }.to raise_error(ArgumentError)
    end
  end

  describe '#call' do
    it 'updates order status' do
      expect { order_service.call }.to change { order.reload.status }.to 'cancelled'
    end

    # proposed by AI
    context 'when the update fails' do
      it 'raises an ActiveRecord::RecordInvalid error' do
        # failure validation update simulation (if reference becomes nil)
        allow(order).to receive(:update!).and_raise(ActiveRecord::RecordInvalid.new(order))
        expect { order_service.call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
