import basic;
import core.time;
import std.process;
import core.thread.osthread;
alias mt = MonoTime;
alias td = Duration;
alias now= mt.currTime;

void draw(T)(T a){
	import asciinumbers;
	"\033[2J\033[1;1H".write;
	//a.writeln;
	time(a.total!"minutes".to!int,a.total!"seconds".to!int%60).write;
}

void main(string[] s){
	if(s.length <2){
		"syntax: the number of timers, the timers space seperated in minutes, the command that runs when done".writeln;
		"./pomodomo 3 1 2 3 ~/.config/wallpaperchanger.sh".writeln;
		"./pomodomo 2 25 5 beep".writeln;
		"./pomodomo 1 300 rm -*".writeln;
		"./pomodomo 16 5 10 20 25 40 45 60 120 180 7 49 420 1337 1 2 3".writeln;
		return;
	}
	mt timerstart;
	bool started;
	int current;
	int[] timers;
	if(s.length>1){
		foreach(i;0..(s[1].to!int)){
			timers~=s[2+i].to!int;
	}}
	auto getcommand(){
		if(s.length<timers.length+1){return "";}
		return s[s[1].to!int+2..$].join(" ");
	}
	auto savedcommand=getcommand;
	bool istime(){
		if(!started){return false;}
		auto foo=now-timerstart;
		return minutes(timers[current])<foo;
	}
	auto timeleft(){
		if( ! started){return td();}
		auto foo=now-timerstart;
		return minutes(timers[current])-foo;
	}
	void starttimer(){
		timerstart=now;
		started=true;
	}
	void update(){
		if(started){
		  if(istime){
			//getcommand.writeln;
			executeShell(savedcommand);
			current++; if(current==timers.length){current=0;}
			starttimer;
		  } else {
			timeleft.draw;
	}}}
	starttimer;
	while(true){
		update;
		Thread.sleep( dur!("msecs")( 100 ) );
	}
}