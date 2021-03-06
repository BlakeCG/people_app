class PeopleController < ApplicationController

  def index
    p 'these are the params'
    p params
    @person = Person.new
    @people = Person.all
    @people = Person.where(mood: params[:mood]) if params[:mood].present?
    @people = @people.where("age >= ?", params[:min_age].to_i) if params[:min_age].present?
    @people = @people.where("age <= ?", params[:max_age].to_i) if params[:max_age].present?
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: "Person Created!"
    else
      redirect_to people_path, alert: @person.errors.full_messages.join(', ')
    end
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to @person, notice: "Person Updated!"
    else
      redirect_to @person, alert: @person.errors.full_messages.join(', ')
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_path, notice: "#{@person.name} Destroyed!"
  end
 
  private
 
  def person_params
    params.require(:person).permit(:name, :age, :mood)
  end

end