require_relative '../../../../week3/session2/models/item'
require_relative '../../../../week3/session2/db/mysql_connector'

describe Item do
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

    describe '#save' do
        context 'when given valid parameter' do

            before(:each) do
                params = {
                    :name       => 'Pasta',
                    :price      => 54000,
                    :categories => []
                }

                @item = Item.new(params)
            end

            it 'should validate params' do
                expect(@item.valid?).to eq(true)
            end

            it 'should save to db' do
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into items(name, price) values('#{@item.name}', '#{@item.price}')")
                @item.save
            end
        end
    end
end


