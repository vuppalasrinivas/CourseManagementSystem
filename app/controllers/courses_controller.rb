class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    if params[:name]
      @courses = Course.where('name ILIKE ?', "%#{params[:name]}%")
    elsif params[:category]
      sub_categories_ids = Category.get_subcategory_ids(params[:category])
      @q = Course.where(category_id: sub_categories_ids).order(created_at: :desc).ransack(params[:q])
      @pagy, @courses = pagy(@q.result.includes(:user, :category))
    else
      @q = Course.order(created_at: :desc).ransack(params[:q])
      @pagy, @courses = pagy(@q.result.includes(:user, :category))
    end
    @categories = Category.where(parent_id: nil)
  end

  # GET /courses/1 or /courses/1.json
  def show
    @lessons = @course.lessons
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course
    @course.user  = current_user
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :price, :short_description, :category_id)
    end
end
