require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    get('user information') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_name: { type: :string }
        },
        required: %w[name user_name]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 user_name: { type: :string },
                 id: { type: :integer },
                 created_at: { type: :string, format: :'date-time' },
                 updated_at: { type: :string, format: :'date-time' }
               },
               required: %w[name user_name id]
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Object)
        end
      end

      response(404, 'user not found') do
        schema type: :object,
               properties: {
                 errors: { type: :string }
               },
               required: ['errors']
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Object)
        end
      end
    end

    post('create user') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          user_name: { type: :string }
        },
        required: %w[name user_name]
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 user_name: { type: :string },
                 id: { type: :integer },
                 created_at: { type: :string, format: :'date-time' },
                 updated_at: { type: :string, format: :'date-time' }
               },
               required: %w[name user_name id]
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Object)
        end
      end

      response(422, 'could not create user') do
        schema type: :object,
               properties: {
                 errors:{ 
                  type: :array,
                  items: { type: :string }
                },
               },
               required: ['errors']
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Object)
        end
      end
    end
  end
end
