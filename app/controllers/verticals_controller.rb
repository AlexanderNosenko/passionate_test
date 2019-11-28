class VerticalsController < ApplicationController

  def index
    authorize(::Vertical)

    render_success(verticals)
  end

  def create
    authorize(::Vertical)

    service = ::Verticals::CreateVertical.call(params)

    render_service(service)
  end

  def show
    authorize(vertical)

    render_success(vertical)
  end

  def update
    authorize(vertical)

    service = ::Verticals::UpdateVertical.call(vertical, params)

    render_service(service)
  end

  def destroy
    authorize(vertical)

    service = ::Verticals::DestroyVertical.call(vertical)

    render_service(service)
  end

  private

  def vertical
    @vertical ||= verticals.find(params[:id])
  end

  def verticals
    @verticals ||= policy_scope(::Vertical)
  end

end
