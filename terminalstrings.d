import basic;
void changecolor(int i){
	i%=8;
	i+=30;
	("\033["~i.to!string~"m").write;
}
void changecolorreadable(int i){
	changecolor(i%7+1);
}
unittest{
	static foreach(i;0..20){
		changecolorreadable(i);
		"hi".writeln;
	}
}
void clearscreen(){
	"\033[2J\033[1;1H".write;
}