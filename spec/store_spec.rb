require("spec_helper")

  describe(store) do


    describe("#shoes") do
      it("returns all of the shoes in a particular store") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        george = Shoe.new({:name => "George Clooney", :id => nil})
        george.save()
        brad = Shoe.new({:name => "Brad Pitt", :id => nil})
        brad.save()
        store.update({:shoe_ids => [george.id(), brad.id()]})
        expect(store.shoes()).to(eq([george, brad]))
      end
    end

    describe("#update") do
      it("lets you add an shoe to a store") do
       store = Store.new({:name => "Oceans Eleven", :id => nil})
       store.save()
       george = Shoe.new({:name => "George Clooney", :id => nil})
       george.save()
       brad = Shoe.new({:name => "Brad Pitt", :id => nil})
       brad.save()
       store.update({:shoe_ids => [george.id(), brad.id()]})
       expect(store.shoes()).to(eq([george, brad]))
      end
    end

    describe("#delete") do
      it("lets you delete a store from the database") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        store2 = Store.new({:name => "Oceans Twelve", :id => nil})
        store2.save()
        store.delete()
        expect(store.all()).to(eq([store2]))
      end
    end
  end
