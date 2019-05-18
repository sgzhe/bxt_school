class IncomingsController < ApplicationController

  # GET /incomings
  # GET /incomings.json
  def index
    facility_id = params[:facility_id]
    org_id = params[:org_id]
    opts = {
        facility_ids: facility_id && BSON::ObjectId(facility_id),
        org_ids: org_id && BSON::ObjectId(org_id),
        status_at_last: params[:status],
        :overtime_at_last.gte => params[:overtime],
        :pass_time_at_last.lte => params[:reside].to_i.days.ago
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end
    @users = paginate(Student.includes(:dept, :dorm).where(opts).or(query).order_by(pass_time_at_last: -1).all)
  end

end
