class PeopleController < ApplicationController


before_action :set_person, :only => [ :show, :edit, :update, :destroy]
before_action :set_page_num


  def index


    if params[:person_id]
      @person = Person.find(params[:person_id])
    else 
      @person = Person.new
    end

    @people = Person.page(params[:page]).per(5)
    Rails.logger.debug("person: #{@person.inspect}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @people.to_xml }
      format.json { render :json => @people.to_json }
      format.atom { @feed_title = "Order list" } # index.atom.builder
    end
  end

  def show
    @feed_title = @person.name

      respond_to do |format|
        format.html { @feed_title = @person.name } # show.html.erb
        format.xml # show.xml.builder
        format.json { render :json => @person.to_json }
        #format.json { render :json => { id: @person.id, name: @person.name, item: @person.item, quantity: @person.quantity, price: @person.price, remark: @person.remark, created_time: @person.created_at }.to_json }
        format.atom { @feed_title = "Order list" } # index.atom.builder
      end
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      params[:page] = Person.count / @page_num + 1 if Person.count > @page_num && Person.count % @page_num != 0
      redirect_to people_path(:page => params[:page])
      flash[:notice] = "知道了啦"
    else
      @people = Person.page(params[:page]).per(5)
      render :index
    end
  end

  def update
    if @person.update(person_params)
      redirect_to people_path(:page => params[:page])
      flash[:notice] = "換來換去很機車喔"
    else
      @people = Person.page(params[:page]).per(5) 
      render :index
    end
  end

  def destroy

    flash[:alert] = "不訂就滾八"


    if Person.count % @page_num == 1 && @person == Person.last
      params[:page] = params[:page].to_i - 1
    end
    @person.destroy
      redirect_to people_path(:page => params[:page])
    
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def set_page_num
    @page_num = 5
  end

  def person_params
    params.require(:person).permit(:name, :item, :quantity, :price, :remark)
  end

end
