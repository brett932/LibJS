const Token = @import("Token.zig");
const std = @import("std");
const Allocator = std.heap.Allocator;
const State = enum {
    main,
};

const Tokenizer = struct {
    input: []const u8,
    output: std.ArrayList(Token),
    cursor: usize = 0,
    state: State = .main,
    pub fn eatWhiteSpace(tk: *Tokenizer) !void {
        var eaten: bool = false;
        while (tk.cursor < tk.input.len) {}
        if (eaten) {
            try tk.output.append(.{ .tag = .white_space });
        }
    }
    pub fn hasInput(tk: Tokenizer) bool {
        return tk.cursor < tk.input.len;
    }
    pub fn run(tk: *Tokenizer) !void {
        while (tk.hasInput()) {
            switch (tk.state) {
                .main => {
                    try tk.eatWhiteSpace();
                },
            }
        }
    }
};
pub fn tokenize(allocator: Allocator, source: []const u8) ![]const Token {
    var tokenizer = Tokenizer{ .input = source, .output = std.ArrayList(Token).init(allocator) };
    try tokenizer.run();
    return tokenizer.output;
}
