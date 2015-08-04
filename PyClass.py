#Python code for classed
def sanitize(time_string):
	#Here the input should be string
	
	if '-' in time_string:
		splitter='-'
	elif ':' in time_string:
		splitter=':'
	else:
		return(time_string)
	(mins, secs) = time_string.split(splitter)
	return(mins+'.'+secs)
	
class Athlete:
	def __init__(self, a_name, a_dob=None, a_times=[]):
		#code to initialize the class Athlete
		self.name=a_name;
		self.dob=a_dob
		self.times=a_times
		#print(self.times)
		
	def _top3(self):
		times=self.times
		print(times)
		clean_times=[]
		for each_item in times:
			clean_times.append(sanitize(each_item))
		clean_times.sort()
		return clean_times[0:3]	
		
	def add_time(self, value=0):
		self.times.append(value)
		
	def add_times(self, value_list=[]):
		for each_time in value_list:
			self.times.append(each_time)


			
class AthleteList(list):
	def __init__(self, a_name, a_dob=None, a_times=[]):
		list.__init__([])
		self.name=a_name
		self.dob=a_dob
		self.extend(a_times)
		
	def top3(self):
		return (sorted(set([sanitize(t) for t in self]))[0:3])


def get_coach_data(filename):
	with open(filename) as tmp:
		dataset=tmp.readline()
		print(dataset)
	data=dataset.strip().split(',')
	#print(data)
	a_name=data.pop(0)
	#print(a_name)
	a_dob=data.pop(0)
	#a_times=data[3: len(data)];
	a_times=data;
	a=AthleteList(a_name, a_dob, a_times)
	#print(a_name)
	return a;
		
#Main Function to call

sarah=get_coach_data('sarah.txt')
print(sarah.name + "'s fast time is: " + str(sarah.top3()))
'''
print('---------------------------------')
sarah.add_time('0.59')
print(sarah.name + "'s fast time is: " + str(sarah.top3()))
print('---------------------------------')
sarah.add_times(['0.34', '0.29'])
print(sarah.name + "'s fast time is: " + str(sarah.top3()))
'''
'''
vera=AthleteList('vera vi')
vera.append('1.00')
print(vera.top3())
print('**************************')
vera.extend(['1.03', '2.14', '0.47', '1-03' ])
print(vera.top3())
'''



