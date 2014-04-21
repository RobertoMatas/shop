require "spec_helper"

describe ProductsController do
	before :each do
		sign_in_as!(create(:user))
	end
	describe "GET index" do
		it "return a 200 status code" do
			get :index
			expect(response.status).to eq(200)
		end
		it "renders the index template" do
			get :index
			expect(response).to render_template :index
		end
		it "populates an array of products" do
			products_list = create_list :product_with_diff_name, 3
			get :index
			expect(assigns(:products)).to eq(products_list)
		end
	end

	describe "GET #show" do
		it "assigns the requested product to @product" do
			product = create :product
			get :show, id: product
			expect(assigns(:product)).to eq(product)
		end
		it "renders the :show template" do
			product = create :product
			get :show, id: product
			expect(response).to render_template :show
		end
	end

	describe "GET #new" do
		it 'assigns a new Product to @product' do
			get :new
			expect(assigns(:product)).to be_a_new(Product)
		end
		it 'renders the :new template' do
			get :new
			expect(response).to render_template :new
		end
	end

	describe "POST create" do
		context "with valid attributes" do
			it "creates a new product" do
				expect {
					post :create, product: attributes_for(:product)
				}.to change(Product, :count).from(0).to(1)
			end
			it "redirects to the new product" do
				post :create, product: attributes_for(:product)
				expect(response).to redirect_to Product.last
			end
		end
		context "with invalid attributes" do
			it "does not save the new product" do
				expect {
					post :create, product: attributes_for(:product, name: nil)
				}.to_not change(Product, :count)
			end
			it "re-renders the new method" do
				post :create, product: attributes_for(:product, name: nil)
				expect(response).to render_template :new
			end
		end
	end

end