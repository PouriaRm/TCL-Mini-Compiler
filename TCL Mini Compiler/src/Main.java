import java.io.FileReader;


public class Main {

	public static void main(String[] argv) throws Exception{
		System.out.println("IF it prints 'identifer' meens defined identifiers,\n"
				+ "when prints 'puts' means it detected 'puts'\n"
				+ "if printed 'if & else' it's shows 'if & else' found.\n"
				+ "and if printed 'forloop' it detects 'for'"
				+ "in the codes.\n");
		Parser p = new Parser(new ScannerCUP(new FileReader("src/test.txt")));
		p.parse();
	    }
}
