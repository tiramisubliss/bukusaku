class Api::V1::EnquiriesController < Api::V1::BaseController
  before_action :set_enquiry, only: [:show, :update, :destroy]

  # GET /enquiries/
  def index
    if params[:page]
      @enquiry = Enquiry.page(params[:page]).per(5)
    else
      @enquiry = Enquiry.order('updated_at DESC')
    end

    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::CollectionSerializer.new(@enquiry, each_serializer: EnquirySerializer)},status: 200
  end

  # GET /enquiries/1
  def show
    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::EnquirySerializer.new(@enquiry).as_json},status: 200
  end

  # DELETE /enquiries/:id
  def destroy
    @enquiry = Enquiry.where(id: params[:id]).first
    if @enquiry.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  # PUT /enquiries/1
  def update
    if @enquiry.update(enquiry_params)
      render json: { status: '200', message: 'OK', data: @enquiry }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @enquiry.errors }, status: :unprocessable_entity
    end
  end

  # POST /enquiries/ "json"
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      render json: { status: '200', message: 'OK', data: @enquiry }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @enquiry.errors }, status: :unprocessable_entity
    end
  end


  private
  # User callback to share common setup or constraints betwen actions
  def set_enquiry
    @enquiry = Enquiry.find(params[:id])
  end

  # only allow a trusted paramater "white list" through
  def enquiry_params
    params.require(:enquiry).permit(:product_id,                                   
                                    :name,
                                    :phone_number,
                                    :job,
                                    :title,
                                    :body
                                    )
  end
end
