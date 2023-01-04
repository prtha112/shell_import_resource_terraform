
resource="confluent_kafka_topic"
resource_name_before_change="$2"
resource_name=$(echo "$resource_name_before_change" | sed -e 's/-/_/g') 
resource_name=$(echo "$resource_name" | sed -e 's/\./_/g')
resource_id=$1

echo $resource
place_string="resource \"$resource\" \"$resource_name\" {}\n"
echo -e $place_string >> topic.tf

terraform import $resource.$resource_name $resource_id/$resource_name_before_change
terraform state show -no-color $resource.$resource_name >> topic.tf 

sed -i '.bak' 's/resource \"$resource\" \"$resource_name\" {}//' topic.tf 