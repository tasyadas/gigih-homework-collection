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
                    :categories => ['1', '2']
                }

                @item = Item.new(params)
            end

            it 'should validate params' do
                expect(@item.valid?).to eq(true)
            end

            it 'should add new item to table items' do
                categories = @item.categories
                mock_client = double

                allow(Mysql2::Client).to receive(:new).and_return(mock_client)

                # add new item
                expect(mock_client).to receive(:query).with("insert into items(name, price) values('#{@item.name}', '#{@item.price}')")

                # create relationship to category
                categories.each do |category|
                    expect(mock_client).to receive(:query).with("
                    INSERT INTO item_categories(item_id, category_id)
                    VALUES(
                        (select id AS item_id from items order by id desc limit 1),
                        ('#{category.to_i}')
                    )
                ")
                end

                result = @item.save

                expect(result).to eq(true)
            end
        end
    end

    describe '#update_single_item' do
        context 'when given valid parameter' do

            before(:each) do
                @update_item = Item.find_single_item(48)
                @update_item.name = 'Capcay'
                @update_item.categories = ['1', '3']
            end

            it 'should validate params' do
                expect(@update_item.valid?).to eq(true)
            end

            it 'should update item to db' do
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)

                # update item
                expect(mock_client).to receive(:query).with(
                    'UPDATE items' +
                    'SET' + 
                        "items.name = '#{@update_item.name}'," +
                        "price = '#{@update_item.price}'" +
                    "WHERE id = '#{@update_item.id}'"
                )

                # delete previous relation
                expect(mock_client).to receive(:query).with("DELETE FROM item_categories WHERE item_id = #{@update_item.id}")

                # update new relation
                @update_item.categories.each do |category|
                    expect(mock_client).to receive(:query).with(
                    'INSERT INTO item_categories (item_id, category_id)' +
                    "VALUES ('#{@update_item.id}', '#{category.to_i}')"
                    )
                end

                result = @update_item.update_single_item

                expect(result).to eq(true)
            end
        end
    end

    describe '#delete_single_item' do
        context 'when given valid parameter' do
            it 'should delete one item from db' do
                @delete_item = Item.find_single_item(48)

                expect(@delete_item.delete_single_item).to eq(true)
            end
        end

        context 'when given invalid parameter' do
            it 'should return false' do
                @delete_item = Item.new({
                    :name       => 'Pasta',
                    :price      => 54000
                })

                expect(@delete_item.delete_single_item).to be_falsey
            end
        end
    end

end


