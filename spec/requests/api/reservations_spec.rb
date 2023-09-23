require 'swagger_helper'

RSpec.describe 'api/reservations', type: :request do

  path '/api/users/{user_id}/reservations' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('list reservations') do
      produces 'application/json'
      response(200, 'successful') do
        let(:user_id) { '123' }
          schema type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                user_id: { type: :integer },
                reservation_date: { type: :string, format: :'date-time' },
                due_date: { type: :string, format: :'date-time' },
                service_fee: { type: :number, format: :float },
                car: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    name: { type: :string },
                    description: { type: :string },
                    location: { type: :string },
                    daily_rate: { type: :number, format: :float },
                    car_type: { type: :string },
                    created_at: { type: :string, format: :'date-time' },
                    updated_at: { type: :string, format: :'date-time' }
                  },
                  required: ['id', 'name', 'description', 'location', 'daily_rate', 'car_type', 'created_at', 'updated_at']
                }
              },
              required: ['id', 'user_id', 'reservation_date', 'due_date', 'service_fee', 'car']
            }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
        end
      end
    end

    post('create reservation') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          reservation_date: { type: :string, format: :'date-time' },
          due_date: { type: :string, format: :'date-time' },
          service_fee: { type: :number, format: :float },
          car_id: { type: :integer }

        },
        required: ['reservation_date', 'due_date', 'service_fee', 'car_id']
      }

      response(200, 'successful') do
        let(:user_id) { '123' }
        schema type: :object,
        properties: {
          id: { type: :integer },
          user_id: { type: :integer },
          reservation_date: { type: :string, format: :'date-time' },
          due_date: { type: :string, format: :'date-time' },
          service_fee: { type: :number, format: :float },
          car: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              location: { type: :string },
              daily_rate: { type: :number, format: :float },
              car_type: { type: :string },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            },
            required: ['id', 'name', 'description', 'location', 'daily_rate', 'car_type', 'created_at', 'updated_at']
          }
        },
        required: ['id', 'user_id', 'reservation_date', 'due_date', 'service_fee', 'car']

        run_test!  do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Object)
      end
    end

    response(404, 'Could not create reservations') do
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

  path '/api/users/{user_id}/reservations/{id}' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation') do
      response(200, 'successful') do
      produces 'application/json'
        let(:user_id) { '123' }
        let(:id) { '123' }
        
        schema type: :object,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer },
            reservation_date: { type: :string, format: :'date-time' },
            due_date: { type: :string, format: :'date-time' },
            service_fee: { type: :number, format: :float },
            car: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                description: { type: :string },
                location: { type: :string },
                daily_rate: { type: :number, format: :float },
                car_type: { type: :string },
                created_at: { type: :string, format: :'date-time' },
                updated_at: { type: :string, format: :'date-time' }
              },
              required: ['id', 'name', 'description', 'location', 'daily_rate', 'car_type', 'created_at', 'updated_at']
            }
          },
          required: ['id', 'user_id', 'reservation_date', 'due_date', 'service_fee', 'car']

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

    delete('delete reservation') do
      produces 'application/json'
      response(200, 'successful') do
        let(:user_id) { '123' }
        let(:id) { '123' }

        schema type: :object,
        properties: {
          message: { type: :string }
        },
        required: ['message']

        run_test! do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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
end
