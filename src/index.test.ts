import { sum, subtract } from './index';

describe('sum', () => {
  it('should add two positive numbers', () => {
    expect(sum(2, 3)).toBe(5);
  });

  it('should add negative numbers', () => {
    expect(sum(-1, -1)).toBe(-2);
  });

  it('should handle zero', () => {
    expect(sum(0, 5)).toBe(5);
  });
});

describe('subtract', () => {
  it('should subtract two numbers', () => {
    expect(subtract(5, 3)).toBe(2);
  });

  it('should handle negative results', () => {
    expect(subtract(3, 5)).toBe(-2);
  });
});