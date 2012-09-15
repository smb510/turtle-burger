function WRWorkout(obj)
{
	this.duration = obj.duration;
	this.exercises = obj.exercises;
}


WRWorkout.prototype = {
	__class__: 'WRWorkout',
	
	setDuration : function(duration)
	{
		this.duration = duration;
	},
	
	setExercises : function(exercises)
	{
		this.exercises = exercises;
	}
}



function WRExercise(obj)
{
	if(obj === undefined)
	{
		
	}
	else
	{
	this.type = obj.type;
	this.duration = obj.duration;
	this.description = obj.description;
	}	
}

WRExercise.prototype = {
	
	__class__: 'WRExercise',
	
	setDuration : function(duration)
	{
		this.duration = duration;
	},
	
	setType : function(type)
	{
		this.type = type;
	},
	setDescription : function(description)
	{
		this.description = description;
	}
	
	
	
}