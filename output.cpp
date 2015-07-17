#include<iostream>
#include<string>
#include<fstream>
#include<cctype>
#include<cstdlib>
#include<cstdio>

using namespace std;

void readFile();
bool readOneline(ifstream &in_stream);
void extractInfo(string line);
string getString(string oneline, int start, int end);
void outputAdapter(string weekday, string time, string room, string course, string code);
int findTime(ifstream &in_stream, string time);
string findPosition(ifstream &in_stream, int &counter, string weekday);
string newLine(string line, string room, string course, string code);
void writeToFile(int counter, string newline);
void copyToFile();
int countComma(string oneline, int number);

int main(){
	readFile();
	return 0;
}


int countComma(string oneline, int number){
	int counter = 0;
	int i = 0;
	for(; counter < number; i++){
		if(oneline[i] == ',')
			counter ++;
	}
	return i-1;
}


void readFile(){
	ifstream in_stream;
	string line;
	
	in_stream.open("hold.txt");
	if(in_stream.fail()){
		cerr << "Cannot open that file" << endl;
		exit(1);
	}
	while(!in_stream.eof()){
		if(!readOneline(in_stream))
			return;
	}
		
 	in_stream.close();
}


bool readOneline(ifstream &in_stream){
	string line;
	getline(in_stream, line);
	if(line.size() < 4)
		return 0;
	//cout << line << endl;
	extractInfo(line);
	return 1;
}

void extractInfo(string line){
	int weekdayPoint;
	int timePoint;
	int roomPoint;
	int coursePoint;
	int codePoint;
	int endPoint;
		
	string weekday;
	string time;
	string room;
	string course;
	string code;
	
	for(int i = 0; i < line.size(); i++){
		if(line[i] == '(')
			weekdayPoint = i;
		/*else if(line[i] == ',' && line[i-1] > 64 && line[i+1] < 64)
			timePoint = i;
		else if(line[i] == ',' && line[i-1] < 64 && line[i+1] < 64)
			roomPoint = i;
		else if(line[i] == ',' && line[i-1] < 64 && line[i+1] > 64)
			coursePoint = i;*/
		else if(line[i] == ')')
			endPoint = i;
	}	
	
	timePoint = countComma(line, 1);
	roomPoint = countComma(line, 2);
	coursePoint = countComma(line, 3);
	codePoint = countComma(line, 4);
	
	weekday = getString(line, weekdayPoint, timePoint);
	time = getString(line, timePoint, roomPoint);
	room = getString(line, roomPoint, coursePoint);
	course = getString(line, coursePoint, codePoint);
	code = getString(line, codePoint, endPoint);
	
	//cout << weekday << endl;
	//cout << time << endl;
	//cout << room << endl;
	//cout << course << endl;
	//cout << code << endl;
	
	outputAdapter(weekday, time, room, course, code);
	
	
}

void outputAdapter(string weekday, string time, string room, string course, string code){
	int counter = 0;
	string line;
	string newline;
	ifstream in_stream;
	in_stream.open("empty.txt");
	if(in_stream.fail()){
		cerr << "Cannot open file" << endl;
		exit(1);
	}
	counter = findTime(in_stream, time);
	//cout << counter << endl;
	line = findPosition(in_stream, counter, weekday);
	//cout << line << endl;
	in_stream.close();
	
	newline = newLine(line, room, course, code);
	
	writeToFile(counter, newline);
	
}

void writeToFile(int counter, string newline){
	string oldline;
	ifstream in_stream;
	ofstream out_stream;
	int newCounter = 0;
	
	copyToFile();
	
	in_stream.open("temp.txt");
	out_stream.open("empty.txt");
	if(in_stream.fail()){
		cerr << "Cannot open instream file" << endl;
		exit(1);
	}
	if(out_stream.fail()){
		cerr << "Cannot open outstream file" << endl;
		exit(1);
	}
	
	while(!in_stream.eof()){
		getline(in_stream, oldline);
		out_stream << oldline << endl;
		if(newCounter == counter - 1){
			getline(in_stream, oldline);
			out_stream << newline << endl;			
		}
		newCounter++;
	}
	                                                       
	in_stream.close();
	out_stream.close();
	remove("temp.txt");
}

void copyToFile(){
	string temp;
	ifstream in_stream;
	ofstream out_stream;
	in_stream.open("empty.txt");
	out_stream.open("temp.txt");
	if(in_stream.fail()){
		cerr << "Cannot open instream file" << endl;
		exit(1);
	}
	if(out_stream.fail()){
		cerr << "Cannot open outstream file" << endl;
		exit(1);
	}
	while(!in_stream.eof()){
		getline(in_stream, temp);
		out_stream << temp << endl;
	}	
	in_stream.close();
	out_stream.close();
}

string newLine(string line, string room, string course, string code){
	string newLine;
	string temp1;
	string temp2;
	size_t position = line.find('>');
	//cout << "Find: " << position << endl;
	temp1 = line.substr(0, position+1);
	temp2 = line.substr(position+1);
	
	//cout << "Line: " << line << endl;
	//cout << "temp1: " << temp1 << endl;
	//cout << "temp2: " << temp2 << endl;
	
	newLine = temp1 + "<br>" + code + " " + course +" / "+room + temp2;
	//cout << newLine << endl;
		
	return newLine;
}



string findPosition(ifstream &in_stream, int &counter, string weekday){
	string result;
	int i = 0;
	int originalCounter = counter;
	if(weekday == "mon")
		counter = counter + 3;
	else if(weekday == "tue")
		counter = counter + 6;
	else if(weekday == "wed")
		counter = counter + 9;
	else if(weekday == "thu")
		counter = counter + 12;
	else if(weekday == "fri")
		counter = counter + 15;
		
	while(!in_stream.eof()){
		getline(in_stream, result);
		if(i == counter- originalCounter - 1){
			return result;
		}
		i++;
	}
	return result;
}

int findTime(ifstream &in_stream, string time){
	int counter = 0;
	string line;
	while(!in_stream.eof()){
		getline(in_stream, line);
		//cout << line << endl;		
		size_t found = line.find(time+"00");
		if(found != std::string::npos){
		  return counter;
		}	
		counter++;
	}
	return counter;
}

string getString(string oneline, int start, int end){
	string result;
	int j = 0;
	for(int i = start + 1; i < end; i++){
		string temp(1,oneline[i]);
		result = result + temp;
	}
	return result;
}