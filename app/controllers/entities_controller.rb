class EntitiesController < ApplicationController
  def index    
    @entities = current_user.entities.order(created_at: :desc)
                .joins(:entity_groups)
                .where(entity_groups: {group_id: params[:group_id]})
                .order(created_at: :desc)                

    @total_amount = @entities.sum(:amount)
  end

  def show
  end

  def new
    @entity = Entity.new
  end

  def edit
  end

  def create
    @entity = Entity.new(entity_params)
    @entity.author_id = current_user.id

    
    respond_to do |format|
      if @entity.save
        @entity_groups = EntityGroups.new(entity_id: @entity.id, group_id: params[:group_id])
        if @entity_groups.save
          format.html { redirect_to group_entities_path(group_id: params[:group_id]), notice: "Entity was successfully created." }
          format.json { render :show, status: :created, location: @entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: "Entity was successfully updated." }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: "Entity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private    
    def set_entity
      @entity = Entity.find(params[:id])
    end
        
    def entity_params
      params.require(:entity).permit(:name, :amount, :author_id)
    end
end
