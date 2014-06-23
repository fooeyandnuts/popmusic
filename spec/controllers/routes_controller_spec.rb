require 'spec_helper'

describe RoutesController do
  let :valid_attributes do
    {
      :lat => "34.013107",
      :lng => "-118.495094",
      :songid => "29098443"
    }
  end

  describe "GET index" do
    let! :route1 do
      Route.create! valid_attributes
    end

    let! :route2 do
      Route.create! valid_attributes
    end

    it "should succeed" do
      get :index
      expect(response).to be_success
    end

    it "should assign routes to all routes" do
      get :index
      expect(assigns(:routes)).to include(route1)
      expect(assigns(:routes)).to include(route2)
    end

    describe "html format" do
      it "should render the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "json format" do
      it "should render the routes in json" do
        get :index, :format => :json
        expect(JSON.parse(response.body)).to have(2).objects
      end
    end
  end

  describe "GET show" do
    before do
      @route = Route.create! valid_attributes
    end

    it "should succeed" do
      get :show, id: @route.id
      expect(response).to be_success
    end

    it "should assign routes to all routes" do
      get :show, id: @route.id
      expect(assigns(:route)).to eq(@route)
    end

    describe "html format" do
      it "should render the index template" do
        get :show, id: @route.id
        expect(response).to render_template :show
      end
    end

    describe "json format" do
      it "should render the route in json" do
        get :show, id: @route.id, format: :json
        expect(JSON.parse(response.body)["id"]).to eq(@route.id)
      end
    end
  end

  describe "GET edit" do
    before do
      @route = Route.create! valid_attributes
      get :edit, id: @route.id
    end

    it "should render the index template" do
      expect(response).to render_template :edit
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign routes to all routes" do
      expect(assigns(:route)).to eq(@route)
    end
  end

  describe "GET new" do
    before do
      get :new
    end

    it "should render the new template" do
      expect(response).to render_template :new
    end

    it "should succeed" do
      expect(response).to be_success
    end

    it "should assign route to be a new route" do
      expect(assigns(:route)).to be_a(Route)
      expect(assigns(:route)).to_not be_persisted
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should create a route in the database" do
        expect do
          post :create, route: valid_attributes
        end.to change(Route, :count).by(1)
      end

      describe "html format" do
        it "should redirect to the index page for routes" do
          post :create, route: valid_attributes
          expect(response).to redirect_to routes_path
        end
      end

      describe "json format" do
        it "should respond with unprocessable status" do
          post :create, route: valid_attributes, format: :json
          expect(response.status).to be(201)
        end

        it "should render the new object as json" do
          post :create, route: valid_attributes, format: :json
          expect(JSON.parse(response.body)["id"]).to eq(Route.last.id)
        end
      end
    end

    describe "unable to save" do
      let :invalid_attributes do
        {
          :lat => nil,
          :lng => nil,
          :songid => nil
        }
      end

      it "should not create any new records in the database" do
        expect do
          post :create, route: invalid_attributes
        end.to_not change(Route, :count).by(1)
      end

      describe "html format" do
        it "should rerender the new template" do
          post :create, route: invalid_attributes
          expect(response).to render_template :new
        end
      end

      describe "json format" do
        it "should respond with unprocessable entity status" do
          post :create, route: invalid_attributes, format: :json
          expect(response.status).to be(422)
        end

        it "should render errors in the model" do
          post :create, route: invalid_attributes, format: :json
          expect(JSON.parse(response.body)["lat"]).to eq(["can't be blank"])
        end
      end
    end
  end

  describe "PUT update" do
    before do
      @test_route = Route.create! valid_attributes
    end

    describe "with successful update" do
      let :update_attributes do
        {
          :lat => "34.013107",
          :lng => "-118.495094",
          :songid => "25344813"
        }
      end

      it "should update the route record in the database" do
        put :update, id: @test_route.id, route: update_attributes
        expect(@test_route.reload.songid).to eq("25344813")
      end

      describe "html format" do
        it "should redirect to the index of all routes" do
          put :update, id: @test_route.id, route: update_attributes
          expect(response).to redirect_to routes_path
        end
      end

      describe "json format" do
        it "should respond with no content" do
          put :update, id: @test_route.id, route: update_attributes, format: :json
          expect(response.status).to be(204)
        end
      end
    end

    describe "with invalid update attributes" do
      let :invalid_update_attributes do
        {
          :lat => "34.013107",
          :lng => "-118.495094",
          :songid => 25344813
        }
      end

      it "should not update the route record in the database" do
        put :update, id: @test_route.id, route: invalid_update_attributes
        expect(@test_route.reload.quantity).to eq(10.0)
      end

      describe "html format" do
        it "should rerender the edit view template" do
          put :update, id: @test_route.id, route: invalid_update_attributes
          expect(response).to render_template :edit
        end
      end

      describe "json format" do
        it "should respond with unprocessable entity status" do
          put :update, id: @test_route.id, route: invalid_update_attributes, format: :json
          expect(response.status).to be(422)
        end

        it "should render errors in the model" do
          put :update, id: @test_route.id, route: invalid_update_attributes, format: :json
          expect(JSON.parse(response.body)["quantity"]).to eq(["must be less than or equal to 12"])
        end
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @route = Route.create! valid_attributes
    end

    it "should delete a record from the database" do
      expect do
        delete :destroy, id: @route.id
      end.to change(Route, :count).by(-1)
    end

    describe "html format" do
      it "should redirect to the index of all routes" do
        delete :destroy, id: @route.id
        expect(response).to redirect_to routes_path
      end
    end

    describe "json format" do
      it "should succeed" do
        delete :destroy, id: @route.id, :format => :json
        expect(response).to be_success
      end
    end
  end
end