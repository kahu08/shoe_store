require("spec_helper")

  describe(shoe) do

    describe("#update") do
      it("lets you add a store to an shoe") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        shoe = Shoe.new({:name => "George Clooney", :id => nil})
        shoe.save()
        shoe.update({:store_ids => [store.id()]})
        expect(shoe.stores()).to(eq([store]))
      end
    end
    describe("#stores") do
        it("returns all of the stores a particular shoe has been in") do
          store = Store.new(:name => "Oceans Eleven", :id => nil)
          store.save()
          store2 = Store.new(:name => "Oceans Twelve", :id => nil)
          store2.save()
          shoe = Shoe.new(:name => "George Clooney", :id => nil)
          shoe.save()
          shoe.update(:store_ids => [store.id()])
          shoe.update(:store_ids => [store2.id()])
          expect(shoe.stores()).to(eq([store, store2]))
        end
      end
    end
