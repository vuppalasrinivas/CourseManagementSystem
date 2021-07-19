json.extract! enrollment, :id, :course_id, :user_id, :price, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
