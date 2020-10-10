class IncomingsController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /incomings
  # GET /incomings.json
  def index
    facility_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    org_id = BSON::ObjectId(params[:org_id]) unless params[:org_id].blank?
    opts = {
        facility_ids: facility_id,
        org_ids: org_id,
        status_at_last: params[:status],
        # :confirmed_at_last.in => [:false, nil]
        # :overtime_at_last.gte => params[:overtime],
        # :pass_time_at_last.lte => params[:reside] && params[:reside].to_i.days.ago,
        # :pass_time_at_last.gte => params[:start_at],
        # :pass_time_at_last.lte => params[:end_at]
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
    cond = [Student.or({ status_at_last: :go_out, :pre_back_at_last.lte => DateTime.now }), Student.or({ :pass_time_at_last.lte => 1.days.ago })]
    criteria = Student.includes(:dept, :dorm).where(opts).where({ :pass_time_at_last.lte => 1.days.ago })
    criteria =  criteria.and(Student.or(query)) unless query.blank?
    criteria = criteria.order_by(pass_time_at_last: -1)
    p criteria
    @users = paginate(criteria)

  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit!
  end
end
