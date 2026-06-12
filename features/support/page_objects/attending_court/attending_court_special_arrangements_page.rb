class AttendingCourtSpecialArrangementsPage < BasePage
 set_url '/steps/attending_court/special_arrangements'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you or the children need specific safety arrangements at court?'
    element :separate_waiting_rooms, 'input[id="steps-attending-court-special-arrangements-form-special-arrangements-separate-waiting-rooms-field"]', visible: false
    element :separate_entrance_exit, 'input[id="steps-attending-court-special-arrangements-form-special-arrangements-separate-entrance-exit-field"]', visible: false
    element :protective_screens, 'input[id="steps-attending-court-special-arrangements-form-special-arrangements-protective-screens-field"]', visible: false
    element :video_link, 'input[id="steps-attending-court-special-arrangements-form-special-arrangements-video-link-field"]', visible: false
    element :special_arrangements_details, 'textarea[name="steps_attending_court_special_arrangements_form[special_arrangements_details]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_special_arrangements(separate_waiting_rooms: false, separate_entrance_exit: false, protective_screens: false, video_link: false, special_arrangements_details: nil)
    content.separate_waiting_rooms.set(separate_waiting_rooms) if separate_waiting_rooms
    content.separate_entrance_exit.set(separate_entrance_exit) if separate_entrance_exit
    content.protective_screens.set(protective_screens) if protective_screens
    content.video_link.set(video_link) if video_link
    content.special_arrangements_details.set(special_arrangements_details) if special_arrangements_details
    
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end