class PeopleController < ApplicationController


before_action :set_person, :only => [ :show, :edit, :update, :destroy]

  def index

    @people = Person.all
    @people = Person.page(params[:page]).per(10)
    Rails.logger.debug("person: #{@person.inspect}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @people.to_xml }
      format.json { render :json => @people.to_json }
      format.atom { @feed_title = "Order list" } # index.atom.builder
    end
  end

  def show
    @page_title = @person.name

      respond_to do |format|
        format.html { @page_title = @person.name } # show.html.erb
        format.xml # show.xml.builder
        format.json { render :json => { id: @person.id, name: @person.name, item: @person.item, quantity: @person.quantity, price: @person.price, remark: @person.remark, created_time: @person.created_at }.to_json }
        format.atom { @feed_title = "Order list" } # index.atom.builder
      end
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    if @person.save

      redirect_to people_path
      flash[:notice] = "知道了啦"
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to people_path
      flash[:notice] = "換來換去很機車喔"
    else
      render :action => :edit
    end
  end

  def destroy

    @person.destroy

    flash[:alert] = "不訂就滾八"

    redirect_to people_path
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :item, :quantity, :price, :remark)
  end

end
