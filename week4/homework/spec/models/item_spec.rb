require_relative '../../../../week3/session2/models/item'
require_relative '../../../../week3/session2/db/test_connector'

describe Item do
    before(:each) do
        @params = {
            'name'       => 'Pasta',
            'price'      => 54000,
            'categories' => ['1', '2']
        }
    end
    
    describe '#valid?' do
        context 'when given valid parameter' do
            it 'should return true' do
                item = Item.new({
                    :name  => 'Pasta',
                    :price => 54000,
                })

                expect(item.valid?).to eq(true)
            end
        end

        context 'when not defining the price' do
            it 'should return false' do
                item = Item.new({
                    'name'  => 'Pasta'
                })

                expect(item.valid?).to be_falsey
            end
        end

        context 'when not defining the name' do
            it 'should return false' do
                item = Item.new({
                    'price' => 54000
                })

                expect(item.valid?).to be_falsey
            end
        end
    end
end


