class shoe < ActiveRecord::Base
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_method(:shoes) do
    store_shoes = []
    results = DB.exec("SELECT shoe_id FROM shoes_stores WHERE store_id = #{self.id()};")
    results.each() do |result|
      shoe_id = result.fetch("shoe_id").to_i()
      shoe = DB.exec("SELECT * FROM shoes WHERE id = #{shoe_id};")
      name = shoe.first().fetch("name")
      store_shoes.push(Shoe.new({:name => name, :id => shoe_id}))
    end
    store_shoes
  end

    define_singleton_method(:all) do
      returned_shoes = DB.exec("SELECT * FROM shoes;")
      shoes = []
      returned_shoes.each() do |shoe|
        name = shoe.fetch("name")
        id = shoe.fetch("id").to_i()
        shoes.push(Shoe.new({:name => name, :id => id}))
      end
      shoes
    end

    define_singleton_method(:find) do |id|
      result = DB.exec("SELECT * FROM shoes WHERE id = #{id};")
      name = result.first().fetch("name")
      shoe.new({:name => name, :id => id})
    end


    define_method(:save) do
      result = DB.exec("INSERT INTO shoes (name) VALUES ('[email protected]}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_shoe|
      self.name().==(another_shoe.name()).&(self.id().==(another_shoe.id()))
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      DB.exec("UPDATE shoes SET name = '#{@name}' WHERE id = #{self.id()};")

      attributes.fetch(:store_ids, []).each() do |store_id|
        DB.exec("INSERT INTO shoes_stores (shoe_id, store_id) VALUES (#{self.id()}, #{store_id});")
      end
    end

    define_method(:stores) do
      shoe_stores = []
      results = DB.exec("SELECT store_id FROM shoes_stores WHERE shoe_id = #{self.id()};")
      results.each() do |result|
        store_id = result.fetch("store_id").to_i()
        store = DB.exec("SELECT * FROM stores WHERE id = #{store_id};")
        name = store.first().fetch("name")
        shoe_stores.push(Store.new({:name => name, :id => store_id}))
      end
      shoe_stores
    end


    define_method(:delete) do
      DB.exec("DELETE FROM shoes_stores WHERE shoe_id = #{self.id()};")
      DB.exec("DELETE FROM shoes WHERE id = #{self.id()};")
    end
end
