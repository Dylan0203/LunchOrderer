atom_feed do |feed|
  feed.title( @feed_title )
  feed.updated( @person.created_at )
  feed.entry(@person) do |entry|
    entry.title( @person.name )
    entry.content( @person.item, :type => 'html' )
    entry.content( @person.quantity)
    entry.content( @person.price)
    entry.content( @person.remark, :type => 'html')
  end
  
end
