import boto.ec2

conn = boto.ec2.connect_to_region('us-west-2')
reservation = conn.run_instances('ami-1799da27', instance_type='t2.micro', subnet_id='subnet-ac05c4db')

instance = reservation.instances[0]
instance.add_tags({'Name':'some-instance-name'})
raw_input("Press ENTER to stop instance")

instance.terminate()
