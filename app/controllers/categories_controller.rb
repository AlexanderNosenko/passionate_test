class CategoriesController < ApplicationController

  def index
    authorize(::Category)

    render_success(categories)
  end

  def create
    authorize(::Category)

    service = ::Categories::CreateCategory.call(params)

    render_service(service)
  end

  def show
    authorize(category)

    render_success(category)
  end

  def update
    authorize(category)

    service = ::Categories::UpdateCategory.call(category, params)

    render_service(service)
  end

  def destroy
    authorize(category)

    service = ::Categories::DestroyCategory.call(category)

    render_service(service)
  end

  private

  def category
    @category ||= categories.find(params[:id])
  end

  def categories
    @categories ||= policy_scope(::Category)
  end

end
