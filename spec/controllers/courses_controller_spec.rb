require 'spec_helper'

describe CoursesController do
  let :valid_attributes do
    {
      :name => "marathon"
    }
  end

  describe "GET index" do
    let! :course1 do
      Course.create! valid_attributes
    end

    let! :course2 do
      Course.create! valid_attributes
    end

    it "should succeed" do
      get :index
      expect(response).to be_success
    end

    it "should assign courses to all courses" do
      get :index
      expect(assigns(:courses)).to include(course1)
      expect(assigns(:courses)).to include(course2)
    end

    describe "html format" do
      it "should render the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "json format" do
      it "should render the courses in json" do
        get :index, :format => :json
        expect(JSON.parse(response.body)).to have(2).objects
      end
    end
  end

  describe "GET show" do
    before do
      @course = Course.create! valid_attributes
    end

    it "should succeed" do
      get :show, id: @course.id
      expect(response).to be_success
    end

    it "should assign courses to all courses" do
      get :show, id: @course.id
      expect(assigns(:course)).to eq(@course)
    end

    describe "html format" do
      it "should render the index template" do
        get :show, id: @course.id
        expect(response).to render_template :show
      end
    end

    describe "json format" do
      it "should render the course in json" do
        get :show, id: @course.id, format: :json
        expect(JSON.parse(response.body)["id"]).to eq(@course.id)
      end
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

    it "should assign course to be a new course" do
      expect(assigns(:course)).to be_a(Course)
      expect(assigns(:course)).to_not be_persisted
    end
  end

  describe "POST create" do
    describe "successful create" do
      it "should create a course in the database" do
        expect do
          post :create, course: valid_attributes
        end.to change(Course, :count).by(1)
      end

      describe "html format" do
        it "should redirect to the index page for courses" do
          post :create, course: valid_attributes
          expect(response).to redirect_to courses_path
        end
      end

      describe "json format" do
        it "should respond with unprocessable status" do
          post :create, course: valid_attributes, format: :json
          expect(response.status).to be(201)
        end

        it "should render the new object as json" do
          post :create, course: valid_attributes, format: :json
          expect(JSON.parse(response.body)["id"]).to eq(Course.last.id)
        end
      end
    end

    describe "unable to save" do
      let :invalid_attributes do
        {
          :name => nil
        }
      end

      it "should not create any new records in the database" do
        expect do
          post :create, course: invalid_attributes
        end.to_not change(Course, :count).by(1)
      end

      describe "html format" do
        it "should rerender the new template" do
          post :create, course: invalid_attributes
          expect(response).to render_template :new
        end
      end

      describe "json format" do
        it "should respond with unprocessable entity status" do
          post :create, course: invalid_attributes, format: :json
          expect(response.status).to be(422)
        end

        it "should render errors in the model" do
          post :create, course: invalid_attributes, format: :json
          expect(JSON.parse(response.body)["name"]).to eq(["can't be blank"])
        end
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @course = Course.create! valid_attributes
    end

    it "should delete a record from the database" do
      expect do
        delete :destroy, id: @course.id
      end.to change(Course, :count).by(-1)
    end

    describe "html format" do
      it "should redirect to the index of all courses" do
        delete :destroy, id: @course.id
        expect(response).to redirect_to courses_path
      end
    end

    describe "json format" do
      it "should succeed" do
        delete :destroy, id: @course.id, :format => :json
        expect(response).to be_success
      end
    end
  end
end