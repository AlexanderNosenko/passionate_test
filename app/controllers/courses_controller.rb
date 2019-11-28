class CoursesController < ApplicationController

  def index
    authorize(::Course)

    render_success(courses)
  end

  def create
    authorize(::Course)

    service = ::Courses::CreateCourse.call(params)

    render_service(service)
  end

  def show
    authorize(course)

    render_success(course)
  end

  def update
    authorize(course)

    service = ::Courses::UpdateCourse.call(course, params)

    render_service(service)
  end

  def destroy
    authorize(course)

    service = ::Courses::DestroyCourse.call(course)

    render_service(service)
  end

  private

  def course
    @course ||= courses.find(params[:id])
  end

  def courses
    @courses ||= policy_scope(::Course)
  end

end
