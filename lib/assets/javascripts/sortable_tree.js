$(document).ready(function(){

    $('.sortable_tree').each(function() {
        $(this).nestedSortable({
            forceHelperSizeType: true,
            errorClass: 'cantdoit',
            disableNesting: 'cantdoit',
            handle: '> .item',
            helper:	'clone',
            listType: 'ol',
            items: 'li',
            opacity: 0.6,
            placeholder: 'placeholder',
            revert: 250,
            maxLevels: $(this).data('max-levels'),
            //maxLevels: #{options[:max_levels] || 5},
            //tabSize: 20,
            // protectRoot: $(this).data('protect-root'),

            // prevent drag flickers
            tolerance: 'pointer',
            toleranceElement: '> div',
            isTree: true,
            startCollapsed: false,
            //startCollapsed: $(this).data("start-collapsed"),

            relocate: function(){
                //$(this).nestedSortable("disable");
                var data = $(this).nestedSortable("serialize");
                var url = $(this).data("sortable-url");

                // update on server
                $.ajax({
                    url: url,
                    type: "post",
                    data: data
                }).always(function(){
                    //$(this).nestedSortable("enable");

                    $(this).find('.item').each(function(index){
                        if (index % 2){
                            $(this).removeClass('odd').addClass('even');
                        }else{
                            $(this).removeClass('even').addClass('odd');
                        }
                    });

                }).done(function(data){

                }).fail(function(jqXHR, textStatus){

                });


                //$(this).nestedSortable("enable");
            }
        }); // nested tree
    });


}); // document.ready
