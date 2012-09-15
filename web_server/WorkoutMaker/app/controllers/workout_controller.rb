require "temboo"
require "Library/Cloudmine"

class WorkoutController < ApplicationController
  def assemble
    session = TembooSession.new("smb510", "turtle-burger", "2125a16f-47ff-4944-b")
    choreo = CloudMine::ObjectStorage::ObjectSearch.new(session)
    inputs = choreo.new_input_set()
    
    inputs.set_APIKey("2c42264d08ea457f8431a40c27494e51")
    inputs.set_ApplicationIdentifier("c697178c50cb4372b6e26ebaf278887b")
    inputs.set_Query("[type = \"" + params[:type] + "\"]")
    results = choreo.execute(inputs)
    parsed_json = ActiveSupport::JSON.decode(results.get_Response)
    @success = parsed_json["success"]
    
    @duration = params[:duration]
    
  end
end
