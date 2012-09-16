function WRWorkout(obj)
{if(obj != undefined)
	{
	this.duration = obj.duration;
	this.exercises = obj.exercises;
}
else
{
	this.duration = 0;
	this.exercises = [];
}
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
	},
	
	addExercise : function(exercise)
	{
		this.exercises.push(exercise);
		
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
	this.title = title;
	this.__id__ = obj.__id__;
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
	setId : function(id)
	{
		this.__id__ = id;
	},
	setTitle : function (title)
	{
		this.title = title;
	}
}
 