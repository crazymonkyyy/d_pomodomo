import basic;
enum ascii=import("asciiart.txt");
auto seperate(int size){
	return ascii
		.splitter!("a == b", Yes.keepSeparators)('\n')
		.chunks(size*2)//splitter is dumb about the seperator
		.array;
}
string sanitize(T)(T a){
	return a.join;
}
enum lines=7;
enum string[11] number=seperate(lines).map!sanitize.array[0..11];
string append(int[] nums...){
	string o;
	auto f(int i){
		return number[i].splitter('\n');
	}
	auto ror=nums.map!f.array;
	foreach(i;0..lines){
	foreach(ref e;ror){
		o~=e.front;
		e.popFront;
	}
		o~='\n';
	}
	return o;
}
string time(int min,int sec){
	if(min>99){
		return append(min/100,(min/10)%10,min%10,10,sec/10,sec%10);
	}else{
		return append((min/10)%10,min%10,10,sec/10,sec%10);
	}
}
//void main(){
//	//append(1,2,10,3,4).writeln;
//	"\033[2J".write;
//	time(23,12).writeln;
//	time(120,00).writeln;
//}