%top{
#include<math.h>
#include<string.h>
int col = 1;
}
%option yylineno
SEMI ;
COMMA ,
ASSIGNOP =
RELOP >|<|>=|<=|==|!=
PLUS \+
MINUS -
STAR \*
DIV "/"
AND &&
OR \|\|
DOT \.
NOT !
TYPE (int)|(float)
LP "("
RP ")"
LB "["
RB "]"
LC "{"
RC "}"
STRUCT (struct)
RETURN (return)
IF (if)
ELSE (else)
WHILE (while)
INT (0|[1-9][0-9]*)
INT8 0[0-7]*
INT16 0[xX][0-9a-fA-F]+
INT8_ERROR 0[0-9]+
INT16_ERROR 0[xX][0-9a-zA-Z]+
NORMAL_FLOAT ([0-9]*[\.][0-9]+|[0-9]+[\.][0-9]*)
SCI_FLOAT {NORMAL_FLOAT}[eE][+-]?{INT}
FLOAT ({NORMAL_FLOAT}|{SCI_FLOAT})
FLOAT_ERROR ({NORMAL_FLOAT}|{INT})[eE]([0-9a-zA-Z]+|{NORMAL_FLOAT})?
ID [A-Za-z_][A-Za-z0-9_]*
%%
"\t" {col += 4;}
" " {col += 1;}
"//" {
	printf("NOTE at line %d,char %d: %s", yylineno, col, yytext); 
	char c; 
	while(true) 
	{
		c = input();
		if(c != '\n' && c != EOF) printf("%c",c); 
		else break;
	}
	printf("\n"); col=1;
}
"/*" {
	char content[100];
	char c = input();
	int flag = 0, index = 0;
	while(c!=EOF){
		while(c == '*'){
			content[index++] = '*';
			c = input();
			col++;
			if(c == '/'){
				flag = 1;
				break;
			}
		}
		content[index++] = c;
		if(flag) break;
		c = input();
		if(c=='\n') col = 1;
	}
	content[index] = '\0';
	if(c == EOF){
		exit(1);
		printf("NOTES error\n");
	}
	printf("NOTE at line %d,char %d: %s", yylineno, col-1, yytext);
	printf("%s\n",content);
}
{SEMI} {printf("SEMI at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{COMMA} {printf("COMMA at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{ASSIGNOP} {printf("ASSIGNOP at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{RELOP} {printf("RELOP at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{PLUS} {printf("PLUS at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{MINUS} {printf("MINUS at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{STAR} {printf("STAR at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{DIV} {printf("DIV at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{AND} {printf("AND at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{OR} {printf("OR at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{DOT} {printf("DOT at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{NOT} {printf("NOT at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{TYPE} {printf("TYPE at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{LP} {printf("LP at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{RP} {printf("RP at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{LB} {printf("LB at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{RB} {printf("RB at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{LC} {printf("LC at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{RC} {printf("RC at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{STRUCT} {printf("STRUCT at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{RETURN} {printf("RETURN at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{IF} {printf("IF at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{ELSE} {printf("ELSE at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{WHILE} {printf("WHILE at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{INT} { printf("INT data at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{INT8} { printf("INT8 at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{FLOAT} { printf("FLOAT at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{INT16} { printf("INT16 at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
{INT16_ERROR} { printf("Error Type A at line %d,char %d: Illegal hexadecimal number: '%s'\n", yylineno, col, yytext); col+=yyleng;}
{INT8_ERROR} { printf("Error Type A at line %d,char %d: Illegal octal number: '%s'\n", yylineno, col, yytext); col+=yyleng;}
{FLOAT_ERROR} { printf("Error Type A at line %d,char %d: Illegal float number: '%s'\n", yylineno, col, yytext); col+=yyleng;}
{ID} {printf("ID at line %d,char %d: %s\n", yylineno, col, yytext); col+=yyleng;}
\n {col = 1;}
. {printf("Error Type A at line %d,char %d: Myterious character: '%s'\n", yylineno, col, yytext); col+=yyleng;}

%%
int main(int argc, char* argv[])
{
	if (argc > 1){
		if(!(yyin = fopen(argv[1], "r"))){
			perror(argv[1]);
			return 1;
		}
		while (yylex() != 0);
	}
	return 0;
}


