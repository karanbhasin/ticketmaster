class TicketsController < ApplicationController
  before_filter :init_controller
  # GET /tickets
  # GET /tickets.xml
  def index
    @tickets = Ticket.where({ :project_id => @project.id })


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])
    @project = Project.find(@ticket.project_id)
    #@ticketHistories = TicketHistory.where({ :ticket_id => params[:id] })
    @ticketHistories = @ticket.ticket_histories
    @ticket_history = TicketHistory.new
    @ticket_history.ticket_id = @ticket.id
    
    #user = User.all
    #@users_array = user.map { |user| [user.email, user.id] }

    @users_array = @project.users.map { |user| [user.email, user.id] }
    @users_array =   ["---"] | @users_array

    #@users_hash = Hash.new(user.map {|u| [u.id, u.email]})
    #@users_hash = Hash[*user.map{|u| [u.id, u.email]}.flatten]
    @users_hash = get_all_users_hash

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new
    @users_array = User.all.map { |user| [user.email, user.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    @users_array = User.all.map { |user| [user.email, user.id] }

  end

  # POST /tickets
  # POST /tickets.xml
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.project_id = params[:project_id]
    @project = Project.find(@ticket.project_id)
    @ticket.created_by_user_id = current_user.id
    @users_array = User.all.map { |user| [user.email, user.id] }

    respond_to do |format|
      if @ticket.save
        #format.html { redirect_to(project_tickets_path(@ticket.project_id), :notice => 'Ticket was successfully created.') }
        format.html { redirect_to(project_path(@project), :notice => 'Ticket was successfully created.') }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find(params[:id])
    @users_array = User.all.map { |user| [user.email, user.id] }

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to(project_ticket_path(@ticket.project_id, @ticket), :notice => 'Ticket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html  do
          render :action => "edit"
        end
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html do
        redirect_to project_tickets_path(@project), :notice => "Ticket deleted successfully."
      end
      format.xml  { head :ok }
    end
  end

  private

  def init_controller
    @project = Project.find params[:project_id]
    @priorities = { :low => 0, :medium => 1, :high =>2 }.freeze
    @actions =  { :Resolved => 0, :Working_as_designed => 1, :Cannot_recreate =>2 }.freeze
  end

end
