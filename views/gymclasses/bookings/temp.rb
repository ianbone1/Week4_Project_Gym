<div class="schedules">
 <form method="post" action="/gymclasses/schedule">
   <div class="schedule">
     <!-- <label for="gymclass_id">Gym Class ID:</label> -->
     <input type="text" name="gymclass_id" id="gymclass_id" value="<%= @gymclass.id %>" hidden/>
     <label for="name">Class Name:</label>
       <input type="text" name="name" id="name" value="<%= @gymclass.name %>" disabled/>
     <label for="description">Class Description:</label>
       <input type="text" name="description" id="description" value="<%= @gymclass.description %>" disabled/>
     <label for="start_date">Start Date:</label>
       <input type="text" name="start_date" id="start_date"/>
     <label for="start_time">Start Time:</label>
       <input type="text" name="start_time" id="start_time"/>
     <label for="duration">Duration:</label>
       <input type="text" name="duration" id="duration"/>
     <label for="maxt_attendees">Max Attendees:</label>
       <input type="text" name="max_attendees" id="max_attendees"/>
   </div>
   <input type="submit" value="Create"/>
 </form>
</div>
