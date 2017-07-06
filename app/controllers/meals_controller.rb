class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]

  # GET /meals
  def index
    @meals = Meal.all
    render json: @meals, status: :ok
  end

  # POST /meals
  def create
    @meal = Meal.create!(meal_params)
    render json: @meal, status: :created
  end

  # GET /meals/1
  def show
    render json: @meal, status: :ok
  end

  # PUT /meals/1
  def update
    @meal.update(meal_params)
    head :no_content
  end

  # DELETE /meals/1
  def destroy
    @meal.destroy
    head :no_content
  end

  private
  # Finds specific model item requested by action
  def set_meal
    @meal = Meal.find(params[:id])
  end

  # Only allow the white-listed parameters through
  def meal_params
    params.permit(:name, :photo, :rating)
  end
end
