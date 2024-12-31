//shader_type canvas_item;
//
//uniform int resX = 64;
//uniform int resY = 32;
//
//// 0.100392156862 is the cube root of 255
//uniform vec3 rgb255 = vec3(0.100392156862, 0.100392156862, 0.100392156862);
//
//void fragment() {
	//float uvX = UV.x - mod(UV.x * float(resX), 1) / float(resX);
	//float uvY = UV.y - mod(UV.y * float(resY), 1) / float(resY);
	//vec2 grid_uv = vec2(uvX, uvY);
//
	//vec4 col = texture(TEXTURE, grid_uv);
//
	//if(col.r < 1.0 && col.g < 1.0 && col.b < 1.0) {
		//vec3 remainder = mod(col.rgb, rgb255);
		//col.rgb = col.rgb - remainder;
	//}
//
	//COLOR = col;
//}


shader_type canvas_item;

uniform int pixel_size : hint_range(1, 100) = 6;

void fragment(){
	vec2 pos = UV / TEXTURE_PIXEL_SIZE;
	vec2 square = vec2(float(pixel_size), float(pixel_size));
	vec2 top_left = floor(pos / square) * square;
	vec4 total = vec4(0., 0., 0., 0.);
	for (int x = int(top_left.x); x < int(top_left.x) + pixel_size; x++){
		for (int y = int(top_left.y); y < int(top_left.y) + pixel_size; y++){
			total += texture(TEXTURE, vec2(float(x), float(y)) * TEXTURE_PIXEL_SIZE);
		}
	}
	COLOR = total / float(pixel_size * pixel_size);
}

