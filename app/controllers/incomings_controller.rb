class IncomingsController < ApplicationController

  # GET /incomings
  # GET /incomings.json
  def index
    facility_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    org_id = BSON::ObjectId(params[:org_id]) unless params[:org_id].blank?
    opts = {
        facility_ids: facility_id,
        org_ids: org_id,
        status_at_last: params[:status],
        :overtime_at_last.gte => params[:overtime],
        :pass_time_at_last.lte => params[:reside] && params[:reside].to_i.days.ago,
        :pass_time_at_last.gte => params[:start_at],
        :pass_time_at_last.lte => params[:end_at]
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end
    match = {facility_ids: facility_id,
             org_ids: org_id}.delete_if { |key, value| value.blank? }
    @status_stats = Student.status_stats(match)
    @users = paginate(Student.includes(:dept, :dorm).where(opts).or(query).order_by(pass_time_at_last: -1))

  end

end
