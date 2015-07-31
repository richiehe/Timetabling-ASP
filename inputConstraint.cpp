#include<iostream>
#include<string>
#include<fstream>

using namespace std;

void openFile();
void convertToFail(ifstream &in_stream);
int stringSearch(string oneline);
int stringSearchBracket(string oneline);

int main(){
	openFile();
	return 0;
}

void writeToFile(string substring, bool first){
	ofstream out_stream;
	if(first)
		out_stream.open("hold_input.txt");
	else
		out_stream.open("hold_input.txt", std::ios_base::app);
		
	if(out_stream.fail()){
		cerr << "Cannot open the file" << endl;
		exit(1);
	}
	out_stream << substring << endl;
	out_stream.close();
}

void convertToFail(ifstream &in_stream){
	string oneline;
	string outputline;
	getline(in_stream, oneline);
	outputline = ":-" + oneline.substr(0, stringSearch(oneline) + 1) + "_).";
	writeToFile(outputline, 1);
	while(!in_stream.eof()){
		getline(in_stream, oneline);
		if(oneline.size() < 4)
			return;
		outputline = ":-" + oneline.substr(0, stringSearch(oneline) + 1) + "_).";
		writeToFile(outputline, 0);
	}
}

int stringSearchBracket(string oneline){
	int result = 0;
	for(int i = 0; i < oneline.size(); i++){
		if(oneline[i] == ')'){
			result = i;
			return result;
		}
	}
	return result;
}





int stringSearch(string oneline){
	int result = 0;
	for(int i = 0; i < oneline.size(); i++){
		if(oneline[i] == ',' && oneline[i-1] < 64 && oneline[i+1] > 64){
			result = i;
			return result;
		}
	}
	return result;
}

void openFile(){
	ifstream in_stream;
	in_stream.open("hold.txt");
	if(in_stream.fail()){
		cerr << "Cannot open the file" << endl;
		exit(1);
	}
	convertToFail(in_stream);
	
	in_stream.close();
}