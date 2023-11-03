// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// $(document).ready(function() {
//     var counter = 0;
//     $('.task-select-check').on('click', function() {
//         if($(this).prop('checked')) {
//             counter += 1;
//             // $('#markCompleted').css('display', 'block');
//             $('#markCompleted').show();
//         } else {
//             counter -= 1;
//             if(counter <= 0) {
//                 // $('#markCompleted').css('display', 'none');
//                 $('#markCompleted').hide();
//             }
//         }
//     });

//     $("#markCompleted").on('click', function() {
//         var taskIDs = [];
        
//         $('.task-select-check').each(function() {
//             if($(this).prop('checked')) {
//                 taskIDs.push($(this).data('task-id'))
//             }
//         });

//         $.ajaxSetup({
//             headers: {
//               'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//             }
//         });

//         $.ajax({
//             // beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
//             url: "/task_block/tasks/bulk_update_task",
//             type: 'patch',
//             data: { task_ids: taskIDs }
//         });
//     });
// });

$(document).ready(function() {

    $(".task-select-check").on('click', function() {
        if($(this).prop('checked')) {
            var taskID = $(this).data('task-id');
            $.ajaxSetup({
                headers: {
                  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                }
            });
    
            $.ajax({
                // beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                url: "/task_block/tasks/update_task",
                type: 'patch',
                data: { task_id: taskID }
            });
        };
    });
});
