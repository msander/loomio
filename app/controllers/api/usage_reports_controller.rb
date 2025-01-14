class API::UsageReportsController < ApplicationController
  skip_before_action :set_sentry_context
  def create
    UsageReport.create!(params[:usage_report])
    head :ok
  end

  private
  def params
    request.parameters
  end
end
