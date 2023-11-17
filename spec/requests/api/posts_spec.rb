require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
  let(:user) { User.create(id: 1, name: 'Felipe', photo: 'url', bio: 'Bio') }

  describe 'Post api' do
    path "/api/v1/users/{user_id}/posts" do
      parameter name: :user_id, in: :path, type: :integer

      post 'Creates a post' do 
        tags 'Posts'
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            text: { type: :string }
          },
          required: ['title', 'text']
        }

        response '201', 'post created' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              text: { type: :string },
              author_id: { type: :integer }
            },
            required: ['id', 'title', 'text', 'author_id']

          let(:user_id) { user.id }
          let(:post) { { title: 'Post 1', text: 'Text 1' } }
          run_test!
        end

        response '422', 'unprocessable entity' do
          schema '$ref' => '#/components/schemas/validation_error'
          let(:user_id) { user.id }
          let(:post) { { title: '', text: '' } } # Invalid data
          run_test!
        end
      end
    end
  end
end
