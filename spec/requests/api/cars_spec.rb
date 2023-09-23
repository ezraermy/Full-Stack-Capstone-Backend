require 'swagger_helper'

RSpec.describe 'api/cars', type: :request do
  path '/api/cars' do
    get('list cars') do
      produces 'application/json'
      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   image: { type: :string },
                   location: { type: :string },
                   daily_rate: { type: :number, format: :float },
                   car_type: { type: :string }
                 },
                 required: %w[id name description image location daily_rate car_type]
               }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create car') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          car_type: { type: :string },
          image: { type: :string },
          location: { type: :string },
          daily_rate: { type: :number, format: :float }
        },
        required: %w[name car_type image location daily_rate]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 car_type: { type: :string },
                 image: { type: :string },
                 location: { type: :string },
                 daily_rate: { type: :number, format: :float }
               },
               required: %w[name car_type image location daily_rate]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'could not create car') do
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
  end

  path '/api/cars/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show car') do
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 car_type: { type: :string },
                 image: { type: :string },
                 location: { type: :string },
                 daily_rate: { type: :number, format: :float }
               },
               required: %w[name car_type image location daily_rate]
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete car') do
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { '123' }
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: ['message']
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'Could not delete reservation') do
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
  end
end
