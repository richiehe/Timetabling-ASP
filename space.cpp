#include<iostream>
#include<fstream>
#include<string>
using namespace std;

void readFile();
void processFile(ifstream &in_stream);
void writeToFile(string substring, bool first);


int main(){
	readFile();
	return 0;
}

void writeToFile(string substring, bool first){
	ofstream out_stream;
	if(first)
		out_stream.open("hold.txt");
	else
		out_stream.open("hold.txt", std::ios_base::app);
		
	if(out_stream.fail()){
		cerr << "Cannot open the file" << endl;
		exit(1);
	}
	out_stream << substring << endl;
	out_stream.close();
}




void processFile(ifstream &in_stream){
	string oneline;
	string substring;
	string rest;
	getline(in_stream, oneline);
	std::size_t found = oneline.find(" ");
	substring = oneline.substr(0, found);
	writeToFile(substring, 1);
	rest = oneline.substr(found + 1);
	
	found = rest.find(" ");
	while(found!=std::string::npos){
		substring = rest.substr(0, found);
		writeToFile(substring, 0);
		rest = rest.substr(found + 1);
		found = rest.find(" ");
		
	}
	writeToFile(rest, 0);
	
	
}


void readFile(){
	ifstream in_stream;
	in_stream.open("original_hold.txt");
	if(in_stream.fail()){
		cerr << "Cannot open the file" << endl;
		exit(1);
	}
	processFile(in_stream);
	
	
	
	in_stream.close();
}