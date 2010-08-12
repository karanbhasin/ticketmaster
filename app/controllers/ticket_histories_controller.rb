class TicketHistoriesController < ApplicationController
  # GET /ticket_histories
  # GET /ticket_histories.xml
  def index
    @ticket_histories = TicketHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket_histories }
    end
  end

  # GET /ticket_histories/1
  # GET /ticket_histories/1.xml
  def show
    @ticket_history = TicketHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket_history }
    end
  end

  # GET /ticket_histories/new
  # GET /ticket_histories/new.xml
  def new
    @ticket_history = TicketHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_history }
    end
  end

  # GET /ticket_histories/1/edit
  def edit
    @ticket_history = TicketHistory.find(params[:id])
  end

  # POST /ticket_histories
  # POST /ticket_histories.xml
  def create
    @ticket_history = TicketHistory.new(params[:ticket_history])
    @ticket = Ticket.find(@ticket_history.ticket_id)
    if params[:user_id] != "---"
      @ticket_history.extra_info = "extra stuff"
    end
    respond_to do |format|
      if @ticket_history.save
        format.html { redirect_to(project_tickets_path(@ticket.project_id), :notice => 'Ticket was successfully created.') }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { redirect_to(project_ticket_path(@ticket.project_id, @ticket)) }
        format.xml  { render :xml => @ticket_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_histories/1
  # PUT /ticket_histories/1.xml
  def update
    @ticket_history = TicketHistory.find(params[:id])

    respond_to do |format|
      if @ticket_history.update_attributes(params[:ticket_history])
        format.html { redirect_to(@ticket_history, :notice => 'Ticket history was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_histories/1
  # DELETE /ticket_histories/1.xml
  def destroy
    @ticket_history = TicketHistory.find(params[:id])
    @ticket_history.destroy

    respond_to do |format|
      format.html { redirect_to(ticket_histories_url) }
      format.xml  { head :ok }
    end
  end
end
