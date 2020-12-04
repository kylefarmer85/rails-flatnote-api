class Api::V1::NotesController < ApplicationController

  def index
    notes = Note.all 
    render json: notes
  end

  def show
      note = Note.find(params[:id])
      render json: note
  end

  def create
 
      note = Note.new(note_params)
      
      if note.save 
          render json: note
      else
          render json: {error: "note requires a title and content!"}, status: 403 
      end

  end

  def update
      note = Note.find(params[:id])
      
      #assigns new attributes to note  
      note.assign_attributes(note_params)
      
      #checks for validation errors
      if note.valid?      
          #saves the assigned updates to the database
          note.save
          render json: note
      else
          render json: note.errors.full_messages
      end
  end

  def destroy
      note = Note.find(params[:id])
      note.destroy

      render json: note
  end



  private

  def note_params
      params.require(:note).permit(:title, :content, :user_id)
  end

end



