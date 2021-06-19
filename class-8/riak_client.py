import riak

client = riak.RiakClient()

bucket = client.bucket('s14902')

user1 = bucket.new('s123456', data={
    'first_name': 'Karol',
    'last_name': 'Karolowski',
    'student_id': 's123456',
    'is_active': True
})
user1.store()

fetchedUser = bucket.get('s123456')
print("Fetched: " + fetchedUser.encoded_data)

fetchedUser.data["is_active"] = False
fetchedUser.store()
fetchedUser = bucket.get('s123456')
print("Fetched updated: " + fetchedUser.encoded_data)

fetchedUser.delete()
fetchedUser = bucket.get('s123456')
print("Fetched deleted: ")
print(fetchedUser.data)
